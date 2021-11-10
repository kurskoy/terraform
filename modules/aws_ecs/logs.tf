resource "aws_cloudwatch_log_group" "main" {
  name              = "${var.app_name}-cloudwatch-log-group"
  retention_in_days = 10
  tags = {
    Name = "${var.app_name}-cloudwatch-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "main" {
  name           = "${var.app_name}-${var.environment}-log-stream"
  log_group_name = aws_cloudwatch_log_group.main.name
}