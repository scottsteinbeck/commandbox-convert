# DocBox Commands

Commandbox Convert is a module for working with excel/csv data. The module utilizes the amazing lucee-spreadsheet created by Julian Halliwell.
The module tries to handle some of the common use cases for working with table like data coming from a csv, excel, or any other valid JSON type data
like an array, array of arrays, array of structs, or a JSON file. 

This module can:

* Convert a csv file to a serialized query for use in piping to other commands
* Converts table like data to excel 
* Converts table like data to csv 
* Converts table like data to json
* Converts table like data to PDF


## LICENSE
Apache License, Version 2.0.

## SYSTEM REQUIREMENTS
- CommandBox 5.3.1+

## Installation
Install the commands via CommandBox like so:
```bash
box install commandbox-convert
```

## Usage

Import and export excel, csv, json, and pdf data through commandbox.

Import a csv or excel file to a query object
Examples:
```bash
csvToQuery inputOrFile="~/Downloads/cities.csv" firstRowIsHeader=true
excelToQuery "~/Downloads/cities.xlsx"
```

Import a csv or excel file to a query object, which can then be piped into other commands
Examples:
```bash
csvToQuery inputOrFile="~/Downloads/cities.csv" firstRowIsHeader=true | sql select="id,name"  | exportTo cities.xlsx
excelToQuery "~/Downloads/POI.xlsx" | sql where="name != 'tom'"  | exportTo POI_list.pdf
```

Export JSON or Query Data to one of many formats including 
```bash
  #extensionlist  | sql select="id,name"  | exportTo extention_list.csv
  #extensionlist  | sql select="id,name"  | exportTo extention_list.xlsx
  #extensionlist  | sql select="id,name"  | exportTo extention_list.json
  #extensionlist  | sql select="id,name"  | exportTo extention_list.pdf
```

----


# CREDITS & CONTRIBUTIONS

I THANK GOD FOR HIS WISDOM FOR THIS PROJECT

## THE DAILY BREAD

"I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12

[1]: https://github.com/Ortus-Solutions/DocBox/wiki
[2]: https://github.com/Ortus-Solutions/DocBox
