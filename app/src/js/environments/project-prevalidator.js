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
        //
        // General options
        //

        if (ValidationUtils.isEmptyString(project.name)) {
            errorBag.add('name', 'projects.create_project.error_project_name_empty')
        }

        if (ValidationUtils.isEmptyString(project.client)) {
            errorBag.add('client', 'projects.create_project.error_client_name_empty')
        }

        if (ValidationUtils.isEmptyString(project.environmentType)) {
            errorBag.add('environmentType', 'projects.create_project.error_environment_type_empty')
        }

        if (ValidationUtils.isEmptyString(project.location)) {
            errorBag.add('location', 'projects.create_project.error_location_empty')
        } 
        else if (!ValidationUtils.isDirectory(project.location)) {
            errorBag.add('location', 'projects.create_project.error_location_not_directory')
        } else if (!ValidationUtils.isDirectoryEmpty(project.location)) {
            errorBag.add('location', 'projects.create_project.error_location_not_empty')
        }

        //
        // Advanced options
        //

        if (!project.useAdvancedOptions) {
            return
        }

        if (ValidationUtils.isEmptyString(project.adminFirstName)) {
            errorBag.add('adminFirstName', 'projects.create_project.error_first_name_empty')
        }

        if (ValidationUtils.isEmptyString(project.adminLastName)) {
            errorBag.add('adminLastName', 'projects.create_project.error_last_name_empty')
        }

        if (ValidationUtils.isEmptyString(project.adminLogin)) {
            errorBag.add('adminLogin', 'projects.create_project.error_admin_login_empty')
        }

        if (ValidationUtils.isEmptyString(project.adminPassword)) {
            errorBag.add('adminPassword', 'projects.create_project.error_admin_password_empty')
        }
        
        if (ValidationUtils.isEmptyString(project.adminEmail)) {
            errorBag.add('adminEmail', 'projects.create_project.error_admin_email_empty')
        }
        
        if (!ValidationUtils.isEmail(project.adminEmail)) {
            errorBag.add('adminEmail', 'projects.create_project.error_admin_email_invalid')
        }
        
        if (ValidationUtils.isEmptyString(project.encryptionKey)) {
            errorBag.add('encryptionKey', 'projects.create_project.error_encryption_key_empty')
        }

        if (!ValidationUtils.isValidEncryptionKey(project.encryptionKey)) {
            errorBag.add('encryptionKey', 'projects.create_project.error_encryption_key_invalid')
        }
    }
}

module.exports = ProjectPrevalidator