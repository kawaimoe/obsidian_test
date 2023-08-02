## Intro to Splunk
### Boolean syntax
#### Order of operations:
1. NOT
2. OR
3. AND

### Quotes in search pattern 
 - If quotation marks are in your targeted events like: 'Failed password for *"john"* at 11:00pm' use an escaping character search:
```SPL
message="Failed password for \\"john\\" at * " 
```

### Operators: OR and IN
• Search for multiple values for a field by using the OR operator 
```SPL
vendorcountry="United States" OR vendorcountry="Canada"
```
• Alternatively, you can use the IN operator
```SPL
vendorcountry IN ("United States","Canada")
```

### Operators: != and NOT
 - The!= field expression and NOT operator exclude events from your search, but may produce different results

`status!=200` - returns all events where the status field exists and it doesn't equal 200
`NOT status=200` - returns all events where the status field exists or not and doesn't equal 200

### fields Command
`...| fields [+|-] [|]`
• Include or exclude specified fields in search results 
• fields or fields+ (default) includes 
• fields- excludes specified fields 
• Supports wildcarded field lists
	The wc in means that fields provided to the fields command can have wildcards.
Example:
`index=security sourcetype=linux_secure (fail* OR invalid) | fields user, app, src_ip`
![[Screenshot 2023-07-25 at 11.10.03.png]]

### Quick regex add-field 
 - using `erex` command you can add a field in the search bar
example: 
` ... | erex ports examples="22,4444,1532"`
`... | erex result examples="Failed login, Successfull login"`

 - after you search this a green icon ill show up in the 'job' button, from here it will give a suggestion to convert your 'erex' into a regular regex value "`rex`", take this suggestions and replace you erex values
### Streaming commands:
 - operate on events as they are returned
	 - eval
	 - search
	 - fields
	 - rename
### Non-streaming Commands
 - Wait until all events are returned before executing. If some streaming commands are used after a transforming command it becomes a non-streaming command
	 - transaction
	 - eval
	 - rename
### Transformation 
 - Order results into a data table
	 - stats
	 - chart
	 - top
	 - rare

NOTE: accelerated reports must include a transforming command

### Report Acceleration Flowchart
![[Screenshot 2023-07-26 at 11.11.35.png]]
![[Screenshot 2023-07-26 at 11.15.02.png]]
![[Screenshot 2023-07-26 at 11.16.08.png]]

