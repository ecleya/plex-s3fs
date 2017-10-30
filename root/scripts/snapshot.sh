#!/usr/bin/with-contenv bash

cd /config
/bin/tar -czf /tmp/plex_db.tar.gz Library --exclude=*/Cache/* "--exclude=*/Crash Reports/*" --exclude=*/Caches/*
/usr/bin/aws s3 cp /tmp/plex_db.tar.gz s3://$BUCKET/Snapshots/plex_db.tar.gz --region=$REGION
/usr/bin/aws s3 cp s3://$BUCKET/Snapshots/plex_db.tar.gz s3://$BUCKET/Snapshots/plex_db.`date +\%F`.tar.gz --region=$REGION
