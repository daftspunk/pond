import React, { PureComponent } from 'react'
import { Field as ReduxFormField } from 'redux-form'
import { Columns } from '../../Elements'
import { Form, Field, Control, Label, Help } from '.'

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
        const fieldLabel = Element.hasInlineLabel ? null : label
        const fieldChildren = Element.hasInlineLabel ? label : null
        const fieldProps = { indent: !!indent }

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

        const fieldType = Form.stringToControlMap[component] || component || Form.Text

        const fieldComponent = this.createRenderer(fieldType)

        return <ReduxFormField {...props} component={fieldComponent} />
    }
}
