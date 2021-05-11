component {

    processingdirective pageEncoding="UTF-8";
    property name="spreadsheet" inject="provider:LuceeSpreadsheet";
    property name="convert" inject="DataConverter";

    /**
     * Outputs a data in one of many different formats (excel, csv, pdf, json)
     * @inputOrFile data or file containing json type data
     * @to File path where the file of the exported data will be created
     * @toType (excel, csv, pdf, json). Optional inferred from the file.
     */

    public string function run(
        required any inputOrFile = '',
        required string to = '',
        boolean overwrite = false,
        string pdfTitle = '',
        string toType = ''
    ) {
        // Treat input as a file path
        var filePath = resolvePath(arguments.inputOrFile);
        if (fileExists(filePath)) {
            arguments.inputOrFile = fileRead(filePath);
        } else {
            arguments.inputOrFile = print.unAnsi(arguments.inputOrFile);
        }

        arguments.to = resolvePath(arguments.to);

        // deserialize data if in a JSON format
        if (isJSON(arguments.inputOrFile)) arguments.inputOrFile = deserializeJSON(arguments.inputOrFile, false);

        var exportType = arguments.toType != '' ? arguments.toType : listLast(arguments.to, '.');
        var dataQuery = convert.toQuery(arguments.inputOrFile);
        var args = {dataQuery: dataQuery, filename: arguments.to, overwrite: arguments.overwrite}
        switch (exportType) {
            case 'excel':
            case 'xlsx':
            case 'xls':
                toExcel(argumentCollection = args);
                break;
            case 'csv':
                toCSV(argumentCollection = args);
                break;
            case 'pdf':
                args.title = arguments.pdfTitle;
                toPDF(argumentCollection = args);
                break;
            case 'json':
                toJSON(argumentCollection = args);
                break;
        }
    }

    public any function toExcel(required dataQuery, required filename, boolean overwrite = false) {
        // Default Styles
        var headerStyles = {
            bold: 'true',
            alignment: 'center',
            verticalalignment: 'center',
            fgColor: '226,226,226',
            color: '0,0,0',
            bottomBorder: 'MEDIUM',
            bottombordercolor: '0,0,0'
        };
        var sheetName = 'Sheet1';
        var workbook = spreadsheet.newStreamingXlsx(sheetName, 10);

        var headerData = arguments.dataQuery.ColumnArray();
        spreadsheet.addRow(workbook = workbook, data = headerData, autoSizeColumns = false);
        // format/adjust the header row
        spreadsheet.setRowHeight(workbook, 1, 23);
        spreadsheet.formatRow(workbook, headerStyles, 1);

        // add the rest of the query
        spreadsheet.addRows(
            workbook = workbook,
            data = arguments.dataQuery,
            includeQueryColumnNames = false,
            autoSizeColumns = true
        );
        spreadsheet.write(workbook, arguments.filename, arguments.overwrite);
    }

    public any function toCSV(required dataQuery, required filename, boolean overwrite = false) {
        workbook = spreadsheet.workbookFromQuery(arguments.dataQuery);
        spreadsheet.writeToCsv(workbook, arguments.filename, arguments.overwrite);
    }

    public any function toPDF(
        required dataQuery,
        required filename,
        boolean overwrite = false,
        string title = ''
    ) {
        document
            format="pdf"
            orientation="landscape"
            filename=arguments.filename
            overwrite=arguments.overwrite
            margintop=".25"
            marginleft=".25"
            marginbottom=".25"
            marginright=".25" {
            include '../includes/print.cfm';
            var headerData = arguments.dataQuery.ColumnArray();
            if (arguments.title != '') echo('<h2>#arguments.title#</h2>');
            echo('<table cellpadding="0" cellspacing="0">');
            echo('<thead>');
            echo('<tr>');
            headerData.each(function(column) {
                echo('<th>#column#</th>');
            })
            echo('</tr>');
            echo('</thead>');
            echo('<tbody>');
            arguments.dataQuery.each(function(row) {
                echo('<tr>');
                headerData.each(function(column) {
                    echo('<td>#row[column]#</td>');
                })
                echo('</tr>');
            })
            echo('</tbody>');
            echo('</table>');
        }
    }

    public any function toJSON(required dataQuery, required filename, boolean overwrite = false) {
        fileWrite(arguments.filename, serializeJSON(dataQuery, 'struct'));
    }

}
