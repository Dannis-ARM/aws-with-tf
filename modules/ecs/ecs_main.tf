resource "aws_ecs_cluster" "example" {
  name = "example-cluster"
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/example-service"
  retention_in_days = 7 # 日志保留时间（可根据需要调整）
}

resource "aws_ecs_task_definition" "example" {
  family                   = "example-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "example-container",
      image     = "nginx:latest",
      cpu       = 256,
      memory    = 512,
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80,
          protocol      = "tcp"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_log_group.name
          awslogs-stream-prefix = "ecs"
          awslogs-region        = var.aws_region
        }
      }
    }
  ])
}

resource "aws_ecs_service" "example" {
  name            = "example-service"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  desired_count   = 1

  network_configuration {
    subnets          = var.ecs_subnet_ids
    security_groups  = [aws_security_group.example.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.example.arn
    container_name   = "example-container"
    container_port   = 80
  }

  launch_type = "FARGATE"
  depends_on  = [aws_lb_listener.example]
}

# Security Group
data "aws_vpc" "ecs_vpc" {
  id = var.ecs_vpc_id
}
resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Allow HTTP access"
  vpc_id      = var.ecs_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.my_public_ip}/32"] # Replace with your public IP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.ecs_vpc.cidr_block] # Allow access from the VPC CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application Load Balancer
resource "aws_lb" "example" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.ecs_subnet_ids
  security_groups    = [aws_security_group.example.id]
}

# Target Group
resource "aws_lb_target_group" "example" {
  name        = "example-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.ecs_vpc_id
  target_type = "ip"

  # Health Check Configuration
  health_check {
    interval            = 60     # Time between health checks (in seconds)
    path                = "/"    # Path to check
    protocol            = "HTTP" # Protocol for health check
    timeout             = 5      # Timeout for health check response
    healthy_threshold   = 3      # Number of successes before marking healthy
    unhealthy_threshold = 3      # Number of failures before marking unhealthy
  }
}

# Listener
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }

  depends_on = [aws_lb_target_group.example]
}
