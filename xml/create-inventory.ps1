# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned
#

$inventory = @"
   <bookstore>
     <book genre="Autobiography">
       <title>The Autobiography of Benjamin Franklin</title>
       <author>
         <first-name>Benjamin</first-name>
         <last-name>Franklin</last-name>
       </author>
       <price>8.99</price>
       <stock>3</stock>
     </book>
     <book genre="Novel">
       <title>Moby Dick</title>
       <author>
         <first-name>Herman</first-name>
         <last-name>Melville</last-name>
       </author>
       <price>11.99</price>
       <stock>10</stock>
     </book>
     <book genre="Philosophy">
       <title>Discourse on Method</title>
       <author>
         <first-name>Rene</first-name>
         <last-name>Descartes</last-name>
       </author>
       <price>9.99</price>
       <stock>1</stock>
     </book>
     <book genre="Computers">
       <title>Windows PowerShell in Action</title>
       <author>
         <first-name>Bruce</first-name>
         <last-name>Payette</last-name>
       </author>
       <price>39.99</price>
       <stock>5</stock>
     </book>
   </bookstore>
"@


Select-Xml -Content $inventory -XPath /bookstore/book | foreach { $_.node }

Select-Xml -Content $inventory -XPath /bookstore/book | foreach { $_.node.title }

Select-Xml -Content $inventory -XPath /bookstore/book/title | foreach { $_.node }

filter node {$_.Node }

Select-Xml -Content $inventory -XPath /bookstore/book | node | where { [double] ($_.price) -lt 10}

Select-Xml -Content $inventory -XPath '/bookstore/book[price < 10]' | node

Select-Xml -Content $inventory -XPath '/bookstore/book/title[../price < 10]' | node

Select-Xml -Content $inventory -XPath '//@genre' | node

Select-Xml -Content $inventory -XPath '//book[@genre = "Novel"]' | node

Select-Xml -Content $inventory -XPath '//book[@genre = "novel"]' | node

Select-Xml -Content $inventory -XPath '//book' | node | where {$_.genre -eq 'novel' }

$nav = ([xml] $inventory).CreateNavigator()
$nav.Evaluate('sum(//book/price)')

#
# Calculate the total value of the inventory by multiplying
# the pirce of each book times the number in stock and then
# summing the results 
#
Select-Xml -content $inventory -xpath '//book' | node | foreach {[double] $_.price * $_.stock } | Measure-Object -sum



#
# Examples using XLINQ to process XML documents
#

# LINQ assemblies are not loaded by default in PowerShell

Add-Type -AssemblyName System.Core
Add-Type -AssemblyName System.Xml.Linq

# Load the document
$ldoc = [system.xml.linq.xdocument] $inventory

# List the titles of all of the books
$ldoc.Descendants("book") | foreach { $_.Element("title").Value }

# Calculate the value of the inventory
$ldoc.Descendants("book") |
    foreach {
        [double] $_.Element("price").value *
            $_.Element("stock").value } |
                Measure-Object -sum | foreach { $_.sum }

# Extract data into PSObjects
$ldoc.Descendants("book") | foreach {
    New-Object PSObject -Property @{
        Title = $_.Element("title").Value
        Stock = $_.Element("stock").Value
        Price = $_.Element("price").value }} |
            Format-Table -AutoSize
