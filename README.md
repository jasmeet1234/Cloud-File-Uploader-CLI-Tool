# Cloud File Uploader CLI Tool

This bash-based CLI tool allows users to quickly upload files to a specified AWS S3 bucket, providing a simple and seamless upload experience. The tool also generates a shareable link for the uploaded file.

## Prerequisites

- **AWS CLI**: Ensure that the AWS CLI is installed and configured on your system.
- **Pipe Viewer (pv)**: This tool is used to show the progress of the upload. You can install it using your package manager (e.g., `sudo apt install pv` on Debian/Ubuntu).

## Installation

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/jasmeet1234/Cloud-File-Uploader-CLI-Tool.git
    cd cloud-file-uploader-cli-tool
    ```

2. **Make the Script Executable**:
    ```sh
    chmod +x clouduploader.sh
    ```

## Usage

### Basic Usage

```sh
./clouduploader.sh /path/to/your/file [target-directory]
```

- **/path/to/your/file**: The path to the local file you want to upload.
- **[target-directory]**: (Optional) The target directory within the S3 bucket. If omitted, the file will be uploaded to the root of the bucket.

### Example

Upload a file `myFile.txt` to the root of the S3 bucket:

```sh
./clouduploader.sh myFile.txt
```

Upload a file `myFile.txt` to a specific directory `/user/folder/` in the S3 bucket:

```sh
./clouduploader.sh myFile.txt /user/folder/
```

## Environment Configuration

The script requires an environment variable `AWSBUCKET` to be set, which specifies the name of the S3 bucket. If the variable is not set, the script will prompt you to enter it, and it will be added to your `.bashrc` file.

## Script Details

### Functions

- **usage**: Displays usage information and exits the script.
- **AWS CLI Check**: Verifies if the AWS CLI is installed.
- **File Check**: Checks if the specified file exists.
- **Environment Variable Check**: Checks if the `AWSBUCKET` environment variable is set, and prompts the user to enter it if not.

### Upload and Progress Indication

The script uses `pv` to show the upload progress and the `aws s3 cp` command to upload the file to the specified S3 bucket.

### Shareable Link

After a successful upload, the script generates a pre-signed URL valid for 1 hour, which can be shared to provide access to the uploaded file.

### Error Handling

The script includes basic error handling to check for the presence of required tools, the existence of the file, and the success of the upload operation.

## Contributing

Feel free to open issues or submit pull requests if you find any bugs or have suggestions for improvements.
