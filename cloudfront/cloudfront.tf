resource "aws_s3_bucket" "b" {
  bucket = "katakam-05"
  acl    = "private"

  tags = {
    Name = "katakam-05"
  }
}
resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id
  policy = file("katakam-05_policy.json")
}

locals {
  s3_origin_id = "S3-katakam-05"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.b.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    }
  

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "terraform-sample-test"
  default_root_object = "index.html"


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
