# Practical 10: Big Data Processing (Hadoop)

This practical introduces the concepts of Big Data and how to use the Hadoop Distributed File System (HDFS) via a Linux-based Virtual Machine.

---

## 1. Definition of Big Data

**Big Data** refers to collections of data that are huge in volume and grow exponentially with time. Because of its massive size and complexity, traditional data management tools (like standard relational databases running on single servers) cannot store or process it efficiently.

*Examples:*
- High-frequency stock exchange trade data.
- Massive ingests of social media uploads and metadata (e.g., Facebook).
- IoT data, such as telematic data generated continuously by jet engines during flight.

---

## 2. Introduction to Hadoop and HDFS

To manage Big Data, a distributed approach is required.

**Hadoop** is an open-source, Java-based framework used for storing and processing big data. 
- It stores data across clusters of inexpensive commodity servers.
- It utilizes the **Hadoop Distributed File System (HDFS)** which enables concurrent processing and provides high fault tolerance.

### Working Environment Setup
For learning purposes, Hadoop is typically run inside a Linux environment virtualized on a host machine:
1. **VirtualBox**: Hypervisor software that runs multiple operating systems on a single device.
2. **Cloudera QuickStart VM**: A pre-configured Linux Virtual Machine containing an active Hadoop instance.

*(Important Configuration Note: When setting up the VM Network Adapter, selecting 'Host-only Adapter' assigns the VM the same IP as the host, while 'Bridged Adapter' gives the VM its own unique IP from the router).*

---

## 3. Interacting with the Hadoop File System (HDFS)

HDFS interactions are performed through a Linux Command Line interface. While HDFS commands look similar to Linux commands, there is a fundamental difference in how they operate regarding paths.

### Stateless Pathing in HDFS
HDFS is **stateless**. Unlike a standard Linux shell which remembers your "current working directory", HDFS does not. 
- *Rule:* Every time you execute a command targeting HDFS, you **must specify the entire absolute directory path** (starting from the root `/`).

### Basic HDFS Commands (`hadoop fs`)

All commands interacting with HDFS must be prefixed with `hadoop fs`.

**1. Listing Files and Directories**
```bash
# List the root directory of HDFS
hadoop fs -ls /

# List the contents of a specific directory
hadoop fs -ls /user
```

**2. Creating Directories**
```bash
# Create a new directory named 'mydata' at the HDFS root
hadoop fs -mkdir /mydata

# Create a nested directory inside 'mydata'
hadoop fs -mkdir /mydata/testfolder
```

**3. Inserting Data (Linux to HDFS)**
To move a file from your local Linux environment *into* the Hadoop cluster, use the `-put` command.
```bash
# Syntax: hadoop fs -put <local_linux_file> <hdfs_destination_path>
hadoop fs -put testfile.txt /mydata/testfolder/
```

**4. Retrieving Data (HDFS to Linux)**
To fetch a file from the Hadoop cluster back *into* your local Linux environment, use the `-get` command.
```bash
# Syntax: hadoop fs -get <hdfs_source_path> <local_linux_destination_name>
hadoop fs -get /mydata/testfolder/testfile.txt newfile.txt
```

---

## Review Questions

**Difficulty: Low**
1. What does the acronym HDFS stand for?
2. Why is HDFS described as being "stateless" compared to a normal Linux file system?
3. What is the mandatory prefix for running shell commands against the Hadoop file system?

**Difficulty: Medium**
4. Write out the exact HDFS command line instruction to create a directory called `backup` inside the `project_data` directory located at the root.
5. You have a file named `daily_logs.csv` in your local Linux folder. Write the command to insert this file into an HDFS directory located at `/user/admin/logs`.
6. Contrast the architectural capability of Hadoop against a traditional RDBMS when dealing with "Big Data". Why is Hadoop necessary?

**Difficulty: High**
7. Discuss the implications of Hadoop running on "inexpensive commodity servers that run as clusters" regarding fault tolerance. If one physical server in the Hadoop cluster suffers a hard drive failure, what happens to the data?
8. In the Cloudera VM network configuration, if you want your virtual machine to act as an independent machine on your local office network so that other computers can access its Hadoop instance, which Network Adapter setting must you choose: 'Host-only Adapter', 'NAT', or 'Bridged Adapter'? Explain why.
9. Write a sequence of two commands: First, retrieve a file named `config.xml` located at `/system/settings/` in HDFS and save it to your local Linux system as `local_config.xml`. Second, list all XML files in your local Linux directory to verify it downloaded correctly.

---
*End of Practical 10 Summary*
