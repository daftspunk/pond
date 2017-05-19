/**
 * Validates data on the first step of the Create Project 
 * form before it's passed to the environment object
 * for further validation and provisioning.
 */

class ProjectPrevalidator {
    constructor () {
        
    }

    isNotEmptyString (value) {
        return String(value).trim().length > 0
    }

    validate (project, errorBag) {
        if (!this.isNotEmptyString(project.name)) {
            errorBag.add('name', 'projects.create_project.error_project_name_empty')
        }

        if (!this.isNotEmptyString(project.client)) {
            errorBag.add('client', 'projects.create_project.error_client_name_empty')
        }

        if (!this.isNotEmptyString(project.environmentType)) {
            errorBag.add('environmentType', 'projects.create_project.error_environment_type_empty')
        }
    }
}

module.exports = ProjectPrevalidator