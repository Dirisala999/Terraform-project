#!/usr/bin/env python3

import boto3
import pytest
import os

def test_bucket_exists():
    s3 = boto3.client('s3')
    bucket_name = os.getenv('S3_BUCKET_NAME')
    assert bucket_name, "S3_BUCKET_NAME not set"
    
    response = s3.head_bucket(Bucket=bucket_name)
    assert response['ResponseMetadata']['HTTPStatusCode'] == 200

def test_bucket_encryption():
    s3 = boto3.client('s3')
    bucket_name = os.getenv('S3_BUCKET_NAME')
    
    response = s3.get_bucket_encryption(Bucket=bucket_name)
    assert 'ServerSideEncryptionConfiguration' in response

def test_bucket_public_access_blocked():
    s3 = boto3.client('s3')
    bucket_name = os.getenv('S3_BUCKET_NAME')
    
    response = s3.get_public_access_block(Bucket=bucket_name)
    config = response['PublicAccessBlockConfiguration']
    
    assert config['BlockPublicAcls'] == True
    assert config['BlockPublicPolicy'] == True
    assert config['IgnorePublicAcls'] == True
    assert config['RestrictPublicBuckets'] == True

if __name__ == "__main__":
    pytest.main([__file__, "-v"])