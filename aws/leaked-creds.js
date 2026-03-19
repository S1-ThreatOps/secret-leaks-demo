const User = require('../models/userModel');
const jwt = require('jsonwebtoken');
const aws = require('aws-sdk');

// Configure AWS SDK with your credentials
aws.config.update({
  accessKeyId: 'AKIAX24QKKOLDSTGRBBC',
  secretAccessKey: 'pnC31rSYpV8wGRVpISqWQHML9GvrKL+YfHu8ihX9',
  region: 'us-east-2'
});

const s3 = new aws.S3();
