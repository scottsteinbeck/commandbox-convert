component {

    processingdirective pageEncoding="UTF-8";
    property name="LuceeSpreadsheet" inject="LuceeSpreadsheet";

    /**
     * Outputs csv data as a serialized query
     * .
     * Required arguments
     * @filepath full file system path of an excel file
     * .
     * Optional arguments
     * @columns _string_: specify the columns you want to read as a comma-delimited list of ranges. Each value can be either a single number or a range of numbers with a hyphen, e.g. "1,2-5"
     * @columnNames _string OR array_: a comma-delimited list or an array of the names to use for the query columns in the order the columns appear in the spreadsheet. Note that specifying `columnNames` overrides the use of a `headerRow` for column names. Alias: `queryColumnNames`.
     * @headerRow _numeric_: specify which row is the header to be used for the query column names
     * @rows _string_: specify the rows you want to read as a comma-delimited list of ranges. Each value can be either a single number or a range of numbers with a hyphen, e.g. "1,2-5"
     * @sheetName _string_: name of the sheet to read
     * @sheetNumber _numeric default=1_: number of the sheet to read (1 based, not zero-based)
     * @includeHeaderRow _boolean default=false_: whether to include the header row from the spreadsheet (NB: the default is the opposite to Adobe ColdFusion 9, which is `excludeHeaderRow=false`).
     * @includeBlankRows _boolean default=false_: whether to include blank rows from the spreadsheet in the query data set. By default blank rows are suppressed.
     * @fillMergedCellsWithVisibleValue _boolean default=false_: if the source sheet contains merged cells, set the value of each cell in the merged region to the visible value stored in the top/left-most cell
     * @includeHiddenColumns _boolean default=true_: if set to false, columns formatted as "hidden" will not be included when reading into a query
     * @includeRichTextFormatting _boolean default=false_: if set to true, basic font formatting of text within cells will be converted to HTML using `<span>` tags with inline CSS styles. Only the following formats are supported:
     * @password _string_: if supplied the file will be treated as encrypted and the password used to try and open it.
     * @csvDelimiter _string default=","_: delimiter to use if reading the file into a CSV string.
     * @queryColumnTypes _string_ or _struct_: when reading a spreadsheet into a query, this allows you to specify the column types (see below for details).
     */




    public any function run(
        required any filepath,
        string format,
        string columns,
        any columnNames,
        numeric headerRow, // list or array
        string rows,
        string sheetName,
        numeric sheetNumber,
        boolean includeHeaderRow = false, // 1-based
        boolean includeBlankRows = false,
        boolean fillMergedCellsWithVisibleValue = false,
        boolean includeHiddenColumns = true,
        boolean includeRichTextFormatting = false,
        string password,
        string csvDelimiter = ',',
        any queryColumnTypes
    ) {
		var data = null;
        // Treat input as a file path
        arguments.filePath = resolvePath(arguments.filePath);
        if (fileExists(arguments.filePath))  data = LuceeSpreadsheet.read( argumentCollection = arguments);

        // pass all arguments to print table
        print.line(data);
    }

}
