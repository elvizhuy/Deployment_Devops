# resource "aws_iam_role" "master" {
#   name               = "${var.name_master}_master"
#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "eks.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.master.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
#   role       = aws_iam_role.master.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#   role       = aws_iam_role.master.name
# }

# ####################################


# resource "aws_iam_policy" "autoscaler" {
#   name   = "${var.name_autoscaler-policy}autoscaler-policy"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "autoscaling:DescribeAutoScalingGroups",
#         "autoscaling:DescribeAutoScalingInstances",
#         "autoscaling:DescribeTags",
#         "autoscaling:DescribeLaunchConfigurations",
#         "autoscaling:SetDesiredCapacity",
#         "autoscaling:TerminateInstanceInAutoScalingGroup",
#         "ec2:DescribeLaunchTemplateVersions"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF

# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "s3" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
#   role       = aws_iam_role.worker.name
# }

# resource "aws_iam_role_policy_attachment" "autoscaler" {
#   policy_arn = aws_iam_policy.autoscaler.arn
#   role       = aws_iam_role.worker.name
# }
# resource "aws_iam_role" "worker" {
#   name               = "${var.name_worker}_worker"
#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_instance_profile" "worker" {
#   depends_on = [aws_iam_role.worker]
#   name       = "${var.name_worker-new-profile}_worker-new-profile"
#   role       = aws_iam_role.worker.name
# }

resource "aws_iam_role_policy_attachment" "Xray" {
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
  role       = var.name_role_woker
}
###############################################################################################################


resource "aws_eks_cluster" "eks" {
  name = "${var.name_eks}_eks"
  # role_arn = aws_iam_role.master.arn
  role_arn = "arn:aws:iam::541253215789:role/eksClusterRole"

  vpc_config {
    subnet_ids = var.subnet_ids
  }


  # depends_on = [
  # aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  # aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
  # aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  # aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,


  #aws_subnet.pub_sub1,
  #aws_subnet.pub_sub2,
  # ]

}
#################################################################################################################

resource "aws_eks_node_group" "staging" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  # node_role_arn   = aws_iam_role.worker.arn
  node_role_arn  = "arn:aws:iam::541253215789:instance-profile/eks-7ac53032-5c83-f386-f389-b52ee86034d5"
  subnet_ids     = var.subnet_ids
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  instance_types = var.instance_types
  remote_access {
    ec2_ssh_key               = var.ec2_ssh_key
    source_security_group_ids = var.sg_id
  }

  labels = tomap({ env = "${var.node_group_name}" })

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  # depends_on = [
  #   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
  #   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
  #   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,

  #aws_subnet.pub_sub1,
  #aws_subnet.pub_sub2,
  # ]
}
