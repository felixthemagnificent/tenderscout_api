server "ec2-34-238-233-234.compute-1.amazonaws.com", user: "deploy", roles: %w{app db web}
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp