const ValidationUtils = require('../validation/utils')

/**
 * Validates data on the first step of the Create Project 
 * form before it's passed to the environment object
 * for further validation and provisioning.
 */

class ProjectPrevalidator {
    constructor () {
        
    }

    validate (project, errorBag) {
        if (ValidationUtils.isEmptyString(project.name)) {
            errorBag.add('name', 'projects.create_project.error_project_name_empty')
        }

        if (ValidationUtils.isEmptyString(project.client)) {
            errorBag.add('client', 'projects.create_project.error_client_name_empty')
        }

        if (ValidationUtils.isEmptyString(project.environmentType)) {
            errorBag.add('environmentType', 'projects.create_project.error_environment_type_empty')
        }
    }
}

module.exports = ProjectPrevalidator