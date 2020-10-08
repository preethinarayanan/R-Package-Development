<img align="right" src="https://brownandbrown.visualstudio.com/3af59049-9c39-49a3-8650-0df57a8e55a4/_apis/git/repositories/c1c80322-050e-45ae-b67c-735c5eec02a7/items?path=%2Finst%2Flogos%2Fpkg-logo.png&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=production&resolveLfs=true&%24format=octetStream&api-version=5.0">

# **kittens**


### Model Development & Data Exploratory Toolkit

**Arrowhead General Insurance Agency**

--- 

### **Overview** 

This package is created to help the data science team at Arrowhead work more efficiently. This package include analytical functions including: modeling, exploring, and data manipulation.

For more information about the package, please contact the data science help email at datasciencehelp@arrowheadgrp.com 


### **Installation**

#### RSSP Install
Kittens is avaialble as a private repository on RSSP. You must add the private repository, and then install it. If you already have it installed in your own library, uninstall it, then follow the instructions below. 

Add the local/private package repository to RSSP IDE:
  a. Tools -> Global Options -> Packages
  b. Add a repository
  c. Name: arrowhead
  d. Url: file:///arrowhead-r-pkgs

Then in your R Console run: 
```
install.packages("kittens")
```

#### Local Install


Clone this repository then run use `devtools` package to install `kittens`. 

```
devtools::install()

```


### **Contributing** 


Please use the following convention when adding functions / features to this package:

  1. Instantiate the `feature-name` branch
  2. Instantiate the `feature-name_dev-name` sub-branch
  3. Treat the `feature-name` branch as master branch to `feature-name_dev-name`
  4. When the `feature-name` branch is ready for primetime, create a Pull Request
  

Function Naming Standardization: 

  1. Use Camel case style for our function names. (e.g. `MakeNames()`, `ModelBinomial()`)
