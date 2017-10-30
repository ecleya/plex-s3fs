# plex-s3fs

plex-s3fs is Plex Media Server image, uses S3 as media storage.

It uses pms-docker as base image. But, it uses S3 as media storage, so /data volume must not set.

## Usage
```
docker run \
-d \
--name plex-s3fs \
--network=host \
-e TZ="<timezone>" \
-e AWS_ACCESS_KEY_ID="<aws_access_key_id>" \
-e AWS_SECRET_ACCESS_KEY="<aws_secret_access_key>" \
-e BUCKET="<S3 bucket name>"
-e REGION="<S3 bucket region>"
-v <path/to/plex/database>:/config \
-v <path/to/transcode/temp>:/transcode \
plex-s3fs
```

### Parameters
* `-e AWS_ACCESS_KEY_ID="<aws_access_key_id>"`: AWS access key id.
* `-e AWS_SECRET_ACCESS_KEY="<aws_secret_access_key>"`: AWS secret access key.
* `-e BUCKET="<S3 bucket name>"`: S3 bucket name.
* `-e REGION="<S3 bucket region>"`: S3 bucket region.
* `-e TZ="<timezone>"`: Timezone
* `-v <path/to/plex/database>:/config`: Recommended. For performance reason. Config data will backup in `s3://<BUCKET>/Snapshots` once a day. If there is no config data, it will automatically restore config data from `s3://<BUCKET>/Snapshots`.
* `-v <path/to/transcode/temp>:/transcode`: Recommended. For performance reason.

### Media data
plex-s3fs searchs media in `s3://<BUCKET>/Plex`.
