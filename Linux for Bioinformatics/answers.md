# Answers to Questions from "Linux for Bioinformatics"

SERGE MERZLIAKOV

25th July 2021

VERSION 2

### Q1. What is your home directory?

	/home/ubuntu

### Q2. What is the output of this command?

	ubuntu@ip-172-31-XX-YY:~/my_folder$ ls
	hello_world.txt


### Q3. What is the output of each ls command?

	ubuntu@ip-172-31-XX-YY:~$ ls my_folder*
	my_folder:
	
	my_folder2:
	hello_world.txt

### Q4. What is the output of each?

	ubuntu@ip-172-31-XX-YY:~$ ls my_folder*
	my_folder:
	
	my_folder2:
	
	my_folder3:
	hello_world.txt
	
	
### Q5. Why didn't that work?
The 'sudouser' does not have permissions configured to log in. There is SSH RSA identity (public-private key pair) for this user.

### Q6. What was the solution?
 
 1. create key pair in AWS and download as PEM file (easier to work with)

 2. Setup ssh in sudouser account
 
		sudouser@ip-172-31-XX-YY:~$ mkdir .ssh
		sudouser@ip-172-31-XX-YY:~$ chmod 700 .ssh
		sudouser@ip-172-31-XX-YY:~$ touch .ssh/authorized_keys
		sudouser@ip-172-31-XX-YY:~$ chmod 600 .ssh/authorized_keys
		
 3.Add public key to sudouser's authorized_keys file
 
 		[client pc] ssh-keygen -y -f sudouser-keypair.pem > public-key.pem
 		[ec2] add contents of public-key.pem to .ssh/authorized_keys
 		

test by logging in with:

	ssh -i sudouser-keypair.pem sudouser@ec2-3-25-QQ-ZZ.ap-southeast-2.compute.amazonaws.com
	
	
### Q7. what does the sudo docker run part of the command do?	and what does the salmon swim part of the command do?
The run command creates a virtual server (docker  container) based on an docker image file, running on the host server (the host). The container is a process (with a complete operating system) running on the host and is controlled by a another process on the host, the docker daemon.

'salmon swim' starts the salmon program in the container with the command line parameter 'swim', which will a perform super-secret operation.

### Q8. What is the output of this command?

	serveruser@ip-172-31-XX-YY:~$ sudo ls /root
	[sudo] password for serveruser: 
	serveruser is not in the sudoers file.  This incident will be reported.

### Q9. what does -c bioconda do?

Adds the 'bioconda' channel as another place to look for the salmon package. Channels are the locations where packages are stored.


### Q10. What is the output of flask --version
	(base) serveruser@ip-172-31-XX-YY:~$ flask --version
	Python 3.8.5
	Flask 1.1.2
	Werkzeug 1.0.1


### Q11. What is the output of mamba -V

Installed with:

	mamba create -n py27 python=2.7

### Q12. What is the output of which python?

	(py27) serveruser@ip-172-31-XX-YY:~$ which python
	/home/serveruser/miniconda3/envs/py27/bin/python
	
	
### Q13. What is the output of which python now?	
	(base) serveruser@ip-172-31-XX-YY:~$ which python
	/home/serveruser/miniconda3/bin/python
	
	
### Q14.What is the output of salmon -h?

	(base) serveruser@ip-172-31-XX-YY:~$ mamba create -n salmonEnv
	(base) serveruser@ip-172-31-XX-YY:~$ conda activate salmonEnv
	(base) serveruser@ip-172-31-XX-YY:~$ mamba install salmon=1.4 -n salmonEnv -c bioconda -c conda-forge
	(base) serveruser@ip-172-31-XX-YY:~$ conda activate salmonEnv
	(salmonEnv) serveruser@ip-172-31-XX-YY:~$ salmon -h
	salmon v1.4.0
	
	Usage:  salmon -h|--help or 
	        salmon -v|--version or 
	        salmon -c|--cite or 
	        salmon [--no-version-check] <COMMAND> [-h | options]
	
	Commands:
	     index      : create a salmon index
	     quant      : quantify a sample
	     alevin     : single cell analysis
	     swim       : perform super-secret operation
	     quantmerge : merge multiple quantifications into a single file

### Q15. What does the -o athal.ga.gz part of the command do?
Writes the downloaded to the file athal.ga.gz (in the current directory), instead of stdout, which just output to the console.

### Q16. What is a .gz file?
A GZ file is an archive file compressed by the standard GNU zip compression algorithm.

### Q17. What does the zcat command do?
Decompresses gzipped files into original format. Equivalent to 'gunzip' or 'gzip -d' commands.

### Q18. what does the head command do?
prints the first 10 lines to output (console STDOUT). The output can be piped to a file as well.

### Q19. what does the number 100 signify in the command?

Show the first 100 lines.

### Q20. What is | doing?
This pipes the output of the command on the left of the pipe to the input of the command on the right of the pipe.

### Q21. What is a .fa file? What is this file format used for?
The FASTA file format.

### Q22. What format are the downloaded sequencing reads in (SRR074122.sra)?
The BAM file format.

### Q23. What is the total size of the disk?

25 GB.

	(base) serveruser@ip-172-31-XX-YY:~/ncbi/public/sra$ df -h
	Filesystem      Size  Used Avail Use% Mounted on
	/dev/root        25G  8.9G   16G  37% /
	devtmpfs        484M     0  484M   0% /dev
	tmpfs           490M     0  490M   0% /dev/shm
	tmpfs            98M  840K   98M   1% /run


### Q24. How much space is remaining on the disk?
16GB.

### Q25. What went wrong?
Nothing, as the AWS free tier allows disk volumes of up to 30GB, and the 25GB disk selected has enough storage to convert files to fastq format.

### Q26. What was your solution? 
Whilst I did not need to do this, the option is to compress the output files using bzip2 option.

	cd /home/serveruser/ncbi/public/sra
	fastq-dump --bzip2 SRR074122 


### Location of quant.sf file

	/home/serveruser/data/transcripts_quant/quant.sf

## Appendix

#### Install sra-tools Command

	(salmonEnv) serveruser@ip-172-31-XX-YY:~/data$ mamba install -c bioconda sra-tools

#### Index Command

	(salmonEnv) serveruser@ip-172-31-XX-YY:~/data$ salmon index -t athal.fa -i transcripts_index -k 31


#### Quantify Reads Command
	(salmonEnv) serveruser@ip-172-31-XX-YY:~/data$ salmon quant -i transcripts_index -l IU -r SRR074122.fastq --validateMappings -o transcripts_quant
