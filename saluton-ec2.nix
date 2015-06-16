let

  region = "us-west-1"; # An ec2 region
  accessKeyId = "dev"; # A key shortname as defined in ~/.ec2-keys

in
{ saluton =
  { resources, ... }:
  { deployment.targetEnv = "ec2";
    deployment.ec2.accessKeyId = accessKeyId;
    deployment.ec2.region = region;
    deployment.ec2.instanceType = "t1.micro";
    deployment.ec2.keyPair = resources.ec2KeyPairs.saluton-keys;

    # deployment.ec2.securityGroups = [ "default" ];
    # EC2's default security group doesn't allow connecting on port 80 by
    # default. Make sure that you have allowed it through the AWS interface
    # before testing if your server is up.
  };

  resources.ec2KeyPairs.saluton-keys =
    { inherit region accessKeyId; };
  # The keypair used to SSH to instances.
}
