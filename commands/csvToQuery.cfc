component {

    processingdirective pageEncoding="UTF-8";
    property name="LuceeSpreadsheet" inject="LuceeSpreadsheet";

    /**
     * Outputs csv data as a serialized query
     * @inputOrFile full file system path of a file containing CSV data
     * @firstRowIsHeader boolean default=false: whether the first line of the CSV contains the column names to use in the query
     * @trim boolean default=true: whether white space should be removed from the beginning and end of the CSV string (usually desirable to prevent blank rows being added to the end of the query)
     * @delimiter default=",": the single delimiter used in the CSV to separate the fields. For tab delimited data, use \t or tab or #Chr( 9 )#.
     * @queryColumnNames the names to use for the query columns in the order the columns appear in the spreadsheet. Note that specifying queryColumnNames overrides the use of firstRowIsHeader.
     * @queryColumnTypes string or struct: the column types to use in the generated query (see below for details).
     */

    public any function run(
        required any inputOrFile,
        boolean firstRowIsHeader = false,
        boolean trim = true,
        string delimiter,
        array queryColumnNames,
        any queryColumnTypes = ''
    ) {
        // Treat input as a file path
        var filePath = resolvePath(arguments.inputOrFile);
        if (fileExists(filePath)) {
            var data = LuceeSpreadsheet.csvToQuery(
                filePath = filePath,
                firstRowIsHeader = arguments.firstRowIsHeader,
                trim = arguments.trim,
                delimiter = arguments.delimiter,
                queryColumnNames = arguments.queryColumnNames,
                queryColumnTypes = arguments.queryColumnTypes
            );
        } else {
            arguments.inputOrFile = print.unAnsi(arguments.inputOrFile);
            var data = LuceeSpreadsheet.csvToQuery(
                csv = arguments.inputOrFile,
                firstRowIsHeader = arguments.firstRowIsHeader,
                trim = arguments.trim,
                delimiter = arguments.delimiter,
                queryColumnNames = arguments.queryColumnNames,
                queryColumnTypes = arguments.queryColumnTypes
            );
        }

        // pass all arguments to print table
        print.line(data);
    }

}
