# Watson timesheet

A script for generating PDF timesheets using [Watson](https://tailordev.github.io/Watson/).
Combines output from `watson report` and `watson log`, while keeping the text fully colored.

## Dependencies

- `watson` (obviously)
- `expect` (for interaction with `watson` and keeping the colors)
- `aha` (for exporting the output to HTML)
- `wkhtmltopdf` (for converting the report file to PDF)

Those can be installed with 2 commands:
- `pip install --user td-watson`
- `sudo apt install expect aha wkhtmltopdf`

## Usage

`./watson-timesheet.sh [tag]`

Report will be generated for all tasks in the current month that have `tag` assigned
to them. The output file will be named `timesheet_[current_year]_[current_month].pdf`.

## Example

Command:

`./watson-timesheet.sh work`

Output file name:

`timesheet_2018_02.pdf`

Output preview:

![sample output](output.png)
