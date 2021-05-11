<style>
@page {
	size:8.5in 11in;
	margin: .4in .5in .75in .5in;
	@bottom-right {
		font-family: Arial, Helvetica, sans-serif;
		font-size:11px;
		content: "Page " counter(page) " of " counter(pages);
	}
}
body{
	font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
}
table {
	-fs-table-paginate: paginate;
	border-spacing: 0;
	width: 100%;
	border-collapse: collapse;
}
body {
	font-family: Arial, Helvetica, sans-serif;
}


table th,
table td {
	padding: 5px;
	font-size: 12px;
	border: 1px solid black;
}
table thead th {
	background-color: rgb(220, 220, 220);
	text-align: center;
	border: 2px solid black;
}
table tr:nth-child(even) {
	background-color: rgb(220, 220, 220);
}
</style>
