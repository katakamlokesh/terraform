resource "aws_iam_role_policy" "lambda_policy-01" {
  name = "lambda_policy-01"
  role = "${aws_iam_role.lambda_role-01.id}"

  policy = "${file("iam/lambda-policy.json")}"
}

resource "aws_iam_role" "lambda_role-01" {
  name = "lambda_role-01"

  assume_role_policy = "${file("iam/lambda-assume-policy.json")}"
}
