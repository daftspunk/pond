import React, { PureComponent } from 'react'
import { Columns } from '../../Elements'
import { Form, Field, Control, Label, Help } from './'
import { Field as ReduxFormField } from 'redux-form'

export default class FormField extends PureComponent {
    // input{ name, onBlur, onChange, onDragStart, onDrop, onFocus, value }
    createRenderer = render => ({
        input,
        meta: { error },
        label,
        comment,
        fullwidth,
        indent,
        ...props
    }) => {
        const Element = render
        const colSize = fullwidth ? 12 : 6
        let fieldLabel = Element.hasInlineLabel ? null : label
        let fieldChildren = Element.hasInlineLabel ? label : null
        let fieldProps = { indent: !!indent }

        return (
            <Columns.Column size={colSize}>
                <Field {...fieldProps}>
                    {fieldLabel && <Label>{fieldLabel}</Label>}
                    <Control>
                        <Element
                            children={fieldChildren}
                            {...input}
                            {...props}
                            color={error && 'danger'}
                        />
                    </Control>
                    {error && <Help color="danger">{error}</Help>}
                    {comment && <Help>{comment}</Help>}
                </Field>
            </Columns.Column>
        )
    }

    render() {
        const { component, ...props } = this.props

        let fieldType = Form.stringToControlMap[component] || component || Form.Text

        let fieldComponent = this.createRenderer(fieldType)

        return <ReduxFormField {...props} component={fieldComponent} />
    }
}
