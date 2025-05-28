resource "aws_lambda_function_url" "local-lambda" {
  function_name      = "arn:aws:lambda:ap-south-1:240925012328:function:Test"
  authorization_type = "NONE"
}

resource "aws_lambda_function_url" "test_live" {
  function_name      = "arn:aws:lambda:ap-south-1:240925012328:function:Test"
  qualifier          = "test_lambda_alias"
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}

resource "aws_lambda_permission" "allow_function_url" {
  statement_id  = "AllowFunctionUrlInvoke"
  action        = "lambda:InvokeFunctionUrl"
  function_name = "arn:aws:lambda:ap-south-1:240925012328:function:Test"
  principal     = "*"
  function_url_auth_type = "NONE"
}

