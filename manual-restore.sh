#!/usr/bin/env bash

set -e

ConsulToken=$1
BackupStorageBucketName=$2
ConsulAddress=$3
ConsulScheme=$4
BACKUP_DATE=$5
Profile=${6:default}

mkdir -p backup
aws s3 cp s3://${BackupStorageBucketName}/manual/kv/$BACKUP_DATE/kv-backup --profile ${Profile} backup/kv
aws s3 cp s3://${BackupStorageBucketName}/manual/kv/$BACKUP_DATE/kv-backup.sig --profile ${Profile} backup/kv.sig
aws s3 cp s3://${BackupStorageBucketName}/manual/acls/$BACKUP_DATE/acls-backup --profile ${Profile} backup/acls
aws s3 cp s3://${BackupStorageBucketName}/manual/acls/$BACKUP_DATE/acls-backup.sig --profile ${Profile} backup/acls.sig

consul-backinator restore -token=${ConsulToken} -addr=${ConsulAddress} -scheme=${ConsulScheme} -prefix=/ -file=backup/kv -acls=backup/acls
