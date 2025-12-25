# AWS Resource Tracker

Track and report AWS resources across your account including IAM users, S3 buckets, EC2 instances, RDS instances, and Lambda functions.

## Usage

```bash
./aws-resource-tracker.sh [region] [--help]
```

## Options

- `region` - AWS region to scan (default: us-east-1)
- `--help` - Show help message

## Examples

```bash
# Use default region (us-east-1)
./aws-resource-tracker.sh

# Scan specific region
./aws-resource-tracker.sh eu-west-1

# Show help
./aws-resource-tracker.sh --help
```

## Output

The script provides a comprehensive overview of:

- **IAM Users** - List of all IAM users
- **S3 Buckets** - All S3 buckets in your account
- **EC2 Instances** - Instance ID, state, and type
- **RDS Instances** - Database identifier, status, and class
- **Lambda Functions** - Function name, runtime, and last modified date

## Prerequisites

- AWS CLI installed and configured
- `jq` installed for JSON parsing
- Appropriate AWS permissions for the resources you want to track

## Error Handling

The script includes built-in checks for:
- AWS CLI installation
- jq installation  
- AWS credentials configuration
- Permission errors (graceful fallback messages)

## Sample Output

```
AWS Resource Tracker - Region: us-east-1
=======================================
IAM Users:
admin-user
developer-user

S3 Buckets:
my-app-bucket
backup-bucket

EC2 Instances:
|  i-1234567890abcdef0  |  running  |  t3.micro  |
|  i-0987654321fedcba0  |  stopped  |  t2.small  |

RDS Instances:
|  mydb-instance  |  available  |  db.t3.micro  |

Lambda Functions:
|  my-function  |  python3.9  |  2023-12-25T10:30:00.000+0000  |

Scan completed for region: us-east-1
```
