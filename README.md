# Metabase Athena Glue

## Description

This repository contains the terraform scripts for setting up AWS Athena, Glue and a CLI user so you can add it to Metabase simply to test

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/metabase-athena-glue.git
    ```

2. Install Terraform

3. Set up CLI keys in your AWS account and add them to the terraform.tfvars file

4. Then init terraform

    ```bash
    terraform init
    ```

4. Deploy

    ```bash
    terraform deploy
    ```

5. Get the keys that were generated for the user 

    ```bash
    terraform output -raw cli_id
    terraform output -raw cli_secret
    ```
6. Ensure that Athena has the "Query result location" set to "s3://athena-metabase-results-test"

7. Now connect Metabase with Athena

Note: make sure that you run "terraform destroy" once the testing is done. You might need to empty the S3 buckets before doing the destroy or you might see an error

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.