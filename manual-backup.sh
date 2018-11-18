#!/usr/bin/env bash

set -e

ConsulToken=$1
BackupStorageBucketName=$2
ConsulAddress=$3
ConsulScheme=$4
Profile=${5:default}

BACKUP_DATE=$(date +%d-%m-%YZ%H-%M-%SZ)
mkdir -p backup
consul-backinator backup -prefix=/ -token=${ConsulToken} -file=backup/kv -acls=backup/acls -addr=${ConsulAddress} -scheme=${ConsulScheme}
aws s3 cp backup/kv s3://${BackupStorageBucketName}/manual/kv/$BACKUP_DATE/kv-backup --profile ${Profile}
aws s3 cp backup/kv.sig s3://${BackupStorageBucketName}/manual/kv/$BACKUP_DATE/kv-backup.sig --profile ${Profile}
aws s3 cp backup/acls s3://${BackupStorageBucketName}/manual/acls/$BACKUP_DATE/acls-backup --profile ${Profile}
aws s3 cp backup/acls.sig s3://${BackupStorageBucketName}/manual/acls/$BACKUP_DATE/acls-backup.sig --profile ${Profile}