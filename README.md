# resume-editor

resume-editor provides a list of commands to edit a resume stored in `resume.json`. It provides an interactive console to execute the commands with the required arguments.

## dependencies

- ruby 2.3.1p112
- Ruby gem - [json](https://rubygems.org/gems/json/versions/1.8.3)

## usage

Usage: COMMAND [ARGS]

Commands:
  help                                    Print this text
  add [attribute]=[value]                 Adds an attribute
  modify [attribute]=[value]              Modifies an attribute
  delete [attribute]                      Deletes an attribute
  read [attribute]                        Prints an attribute's value
  display                                 Pretty prints the resume object
  quit                                    Quits the console

## execution

```sh
$ cd resume-editor
$ rake
resume-editor>>> display
{
  "name": "Khusbu Mishra",
  "phone": "9999999999"
}
resume-editor>>> add location=Kolkata
success: `location` set to `Kolkata`
resume-editor>>> display
{
  "name": "Khusbu Mishra",
  "phone": "9999999999",
  "location": "Kolkata"
}
resume-editor>>> modify location=Bengaluru
success: `location` set to `Bengaluru`
resume-editor>>> display
{
  "name": "Khusbu Mishra",
  "phone": "9999999999",
  "location": "Bengaluru"
}
resume-editor>>> read location
location = Bengaluru
resume-editor>>> delete location
`location` deleted from the resume
resume-editor>>> display
{
  "name": "Khusbu Mishra",
  "phone": "9999999999"
}
```

## tests

To execute tests, run the following command:

```sh
$ rake test
```

## next-milestone
- Better interface to edit and add nested JSON fields.
- Better interactive console.
