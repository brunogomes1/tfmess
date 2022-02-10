# tfmess

1. [Introduction](#intro)
2. [Options](#issue)
3. [The Script](#script)
4. [Options](#options)
5. [Usage](#usage)

## Introdution <a name="intro"></a>

- My itention to create this script was to make my life easier when working on a project that in a single folder we would have dozens Terraform files (.tf).

## The issue <a name="issue"></a>

- If I wanted to change an specific module like a S3 Bucket I would have to go through the file, find the module I want to work on, copy its name, go to the CLI and type: "`terraform plan -target=module.bucket-1`". And if I wanted to change more than one bucket I would have to search for the other one I wanted and do: "`terraform plan -target=module.bucket-1 -target=module.bucket-2`".
- As you can imagine we wouldn't have just 2 buckets or talking about other resources like CloudFront we would have more than 10, so imagine doing the above 10 times.

## The script <a name="script"></a>

1. The script will go through the file you choose, and find all occurences of modules.
2. Then it will output them to the terminal in the format we want.
3. After outputing all modules that were found, it will ask prompt to do a terraform `plan` or `apply` depending on the flag you passed.

## Options <a name="options"></a>

* **--tfplan**: Ouputs the modules found in the terminal and asks if you would like to run a `terraform plan`
* **--tfapply**: Ouputs the modules found in the terminal and asks if you would like to run a `terraform apply`

## Usage: <a name="usage"></a>

1. Prior running the script you must run `terraform fmt`.
2. You can also run: "`chmod +x tfmess.sh`" to make sure it will work.

### Sample order of steps:
```bash
chmod +x tfmess.sh 

./tfmess.sh --tfplan

Choose the .tf file you would like to work on: s3_buckets.tf

s3_buckets.tf found.

List of modules that were found in the file: 

-target=module.bucket-1  -target=module.bucket-2  -target=module.bucket-3  -target=module.bucket-4  -target=module.bucket-5 

Would you like to run Terraform Plan against all modules that were found? (Y/N) Y

Error: Missing required argument

  on s3_buckets.tf line 1, in module "bucket-1":
   1: module "bucket-1"{}

The argument "source" is required, but no definition was found.


Error: Missing required argument

  on s3_buckets.tf line 3, in module "bucket-2":
   3: module "bucket-2"{}

The argument "source" is required, but no definition was found.


Error: Missing required argument

  on s3_buckets.tf line 5, in module "bucket-3":
   5: module "bucket-3"{}

The argument "source" is required, but no definition was found.


Error: Missing required argument

  on s3_buckets.tf line 7, in module "bucket-4":
   7: module "bucket-4"{}

The argument "source" is required, but no definition was found.


Error: Missing required argument

  on s3_buckets.tf line 9, in module "bucket-5":
   9: module "bucket-5"{}

The argument "source" is required, but no definition was found.
```