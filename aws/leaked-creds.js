const User = require('../models/userModel');
const jwt = require('jsonwebtoken');
const aws = require('aws-sdk');

// Configure AWS SDK with your credentials
aws.config.update({
  accessKeyId: 'AKIA3J3UHE32K5BQEH4U',
  secretAccessKey: 'P3o3DmppCeRn81zMTlH8QiTcayerJZ1EFQbZAVxl',
  region: 'us-east-2'
});

const s3 = new aws.S3();
