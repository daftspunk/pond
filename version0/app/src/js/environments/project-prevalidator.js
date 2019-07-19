import validationUtils from '../validation/utils'
import validator from 'validator'

/**
 * Validates data on the first step of the Create Project 
 * form before it's passed to the environment object
 * for further validation and provisioning.
 *
 * It would be nice to have a validation library,
 * but it should be really simple and working with custom rules.
 *
 */

class ProjectPrevalidator {
    constructor () {
        
    }

    validate (project, errorBag) {
        //
        // General options
        //

        if (validator.isEmpty(validationUtils.toSafeString(project.name))) {
            errorBag.add('name', 'projects.create_project.error_project_name_empty')
        }

        if (validator.isEmpty(validationUtils.toSafeString(project.client))) {
            errorBag.add('client', 'projects.create_project.error_client_name_empty')
        }

        if (validator.isEmpty(validationUtils.toSafeString(project.environmentType))) {
            errorBag.add('environmentType', 'projects.create_project.error_environment_type_empty')
        }

        if (validator.isEmpty(validationUtils.toSafeString(project.location))) {
            errorBag.add('location', 'projects.create_project.error_location_empty')
        } 
        else if (!validationUtils.isDirectory(project.location)) {
            errorBag.add('location', 'projects.create_project.error_location_not_directory')
        }
        else if (!validationUtils.isDirectoryEmpty(project.location)) {
            errorBag.add('location', 'projects.create_project.error_location_not_empty')
        }

        //
        // Advanced options
        //

        if (!project.useAdvancedOptions) {
            return
        }

        if (validator.isEmpty(validationUtils.toSafeString(project.adminFirstName))) {
            errorBag.add('adminFirstName', 'projects.create_project.error_first_name_empty')
        }

        if (validator.isEmpty(validationUtils.toSafeString(project.adminLastName))) {
            errorBag.add('adminLastName', 'projects.create_project.error_last_name_empty')
        }

        if (validator.isEmpty(validationUtils.toSafeString(project.adminLogin))) {
            errorBag.add('adminLogin', 'projects.create_project.error_admin_login_empty')
        }

        if (validator.isEmpty(validationUtils.toSafeString(project.adminPassword))) {
            errorBag.add('adminPassword', 'projects.create_project.error_admin_password_empty')
        }
        
        if (validator.isEmpty(validationUtils.toSafeString(project.adminEmail))) {
            errorBag.add('adminEmail', 'projects.create_project.error_admin_email_empty')
        }
        else if (!validator.isEmail(project.adminEmail)) {
            errorBag.add('adminEmail', 'projects.create_project.error_admin_email_invalid')
        }
        
        if (validator.isEmpty(validationUtils.toSafeString(project.encryptionKey))) {
            errorBag.add('encryptionKey', 'projects.create_project.error_encryption_key_empty')
        }
        else if (!validator.isLength(validationUtils.toSafeString(project.encryptionKey), {min: 32, max: 32})) {
            errorBag.add('encryptionKey', 'projects.create_project.error_encryption_key_invalid')
        }
    }
}

export default ProjectPrevalidator