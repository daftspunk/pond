import React, { PureComponent } from 'react'
import { FormSection } from 'redux-form'
import InputControl from './Controls/Input'
import TextareaControl from './Controls/Textarea'
import SelectControl from './Controls/Select'
import CheckboxControl from './Controls/Checkbox'
import RadioControl from './Controls/Radio'
import FileControl from './Controls/File'
import { Columns } from '../../Elements'
import FormField from './Form.Field'
import styles from './Form.scss'

export default class Form extends PureComponent {
    static Text = props => <InputControl {...props} />

    static Password = props => <InputControl type="password" {...props} />

    static Textarea = props => <TextareaControl {...props} />

    static Dropdown = props => <SelectControl {...props} />

    static Checkbox = props => <CheckboxControl {...props} />

    static Radio = props => <RadioControl {...props} />

    static FileUpload = props => <FileControl {...props} />

    static stringToControlMap = {
        'text': Form.Text,
        'password': Form.Password,
        'textarea': Form.Textarea,
        'dropdown': Form.Dropdown,
        'fileupload': Form.FileUpload,
        'checkbox': Form.Checkbox,
    }

    static Section = (props) => <FormSection component={(propss) => <React.Fragment {...propss} />} {...props} />

    static EmptyField = (props) => <Columns.Column size={6} {...props} />

    static Field = FormField

    constructor(props) {
        super(props)
        Form.Checkbox.hasInlineLabel = true
    }

    render() {
        const { children, ...allProps } = this.props
        return (
            <form {...allProps}>
                <Columns multiline>
                    {children}
                </Columns>
            </form>
        )
    }
}
