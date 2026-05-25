import boto3
import argparse
import json
from constants import *

ec2=boto3.client(
"ec2",
endpoint_url="http://localhost:4566",
region_name=REGION,
aws_access_key_id="test",
aws_secret_access_key="test"
)

findings=[]

def check_orphan_ebs():

    volumes=ec2.describe_volumes()

    for v in volumes["Volumes"]:

        if v["State"]=="available":

            findings.append({

                "type":"orphan-ebs",

                "id":v["VolumeId"]

            })


def check_missing_tags():

    reservations=ec2.describe_instances()

    for r in reservations["Reservations"]:

        for i in r["Instances"]:

            tags={

                t["Key"]

                for t in i.get("Tags",[])

            }

            missing=[

                t

                for t in REQUIRED_TAGS

                if t not in tags

            ]

            if missing:

                findings.append({

                    "type":"missing-tags",

                    "instance":i["InstanceId"],

                    "missing":missing

                })


def generate_report():

    with open("report.json","w") as f:

        json.dump(findings,f,indent=2)

    with open("summary.md","w") as f:

        f.write("# Cost Report\n\n")

        f.write(f"Findings: {len(findings)}")


if __name__=="__main__":

    parser=argparse.ArgumentParser()

    parser.add_argument(
        "--delete",
        action="store_true"
    )

    parser.add_argument(
        "--dry-run",
        action="store_true"
    )

    args=parser.parse_args()

    check_orphan_ebs()

    check_missing_tags()

    generate_report()

    print(findings)

    if findings:

        exit(1)
