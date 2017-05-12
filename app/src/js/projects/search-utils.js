function projectMatchesSearchString(project, filterString) {
    return filterString.length == 0 
        || project.name.toLowerCase().indexOf(filterString.toLowerCase()) !== -1
        || project.client.toLowerCase().indexOf(filterString.toLowerCase()) !== -1
}

module.exports = {
    projectMatchesSearchString
}