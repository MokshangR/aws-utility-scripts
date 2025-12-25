# AWS Utility Scripts

A collection of practical AWS utility scripts for resource management, monitoring, and automation.

## 🚀 Scripts

### AWS Resource Tracker
Track and report AWS resources across your account.

**Usage:**
```bash
./resource-tracker/aws-resource-tracker.sh [region]
```

**Example:**
```bash
# Use default region (us-east-1)
./resource-tracker/aws-resource-tracker.sh

# Specify region
./resource-tracker/aws-resource-tracker.sh eu-west-1
```

**Output:**
- IAM Users
- S3 Buckets  
- EC2 Instances (ID, State, Type)
- RDS Instances (ID, Status, Class)
- Lambda Functions (Name, Runtime, Last Modified)

## 📋 Prerequisites

- AWS CLI installed and configured
- `jq` installed for JSON parsing
- Appropriate AWS permissions for the resources you want to track

## 🛠️ Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd aws-utility-scripts
```

2. Make scripts executable:
```bash
chmod +x resource-tracker/*.sh
```

3. Run the script:
```bash
./resource-tracker/aws-resource-tracker.sh
```

## 🔧 Configuration

Ensure your AWS CLI is configured:
```bash
aws configure
```

Or use environment variables:
```bash
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
export AWS_DEFAULT_REGION=us-east-1
```

## 📝 License

MIT License - feel free to use and modify.

## 🤝 Contributing

Pull requests welcome! Please ensure scripts are tested and documented.
