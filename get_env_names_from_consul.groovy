import groovy.json.JsonSlurper

// get text from URL, parse json, store data in an array
def list = new JsonSlurper().parseText( new URL ("http://consul.somewhere.com:8500/v1/kv/dbconns/?keys").getText() )


// remove all parts of each string in array that isn't environment name
for (int index =0; index < list.size; index++){
  list[index] = list[index].replace("dbconns/", "").split("/", 2)[0];
}

// remove all duplicate and empty values
list = list.unique { a, b -> a <=> b }.findAll {it != "" }

// print env names
for (int index =0; index < list.size; index++){
  println  list[index];
}
