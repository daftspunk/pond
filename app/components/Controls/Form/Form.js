import React, { PureComponent } from 'react';
import InputControl from './Controls/Input';
import TextareaControl from './Controls/Textarea';
import SelectControl from './Controls/Select';
import CheckboxControl from './Controls/Checkbox';
import RadioControl from './Controls/Radio';
import { Columns } from '../../Elements';
import { Field, Control, Label, Help } from './';
import { Field as ReduxFormField } from 'redux-form'
import styles from './Form.scss';

export default class Form extends PureComponent {
    static Text = props => <InputControl {...props} />;
    static Password = props => <InputControl type="password" {...props} />;
    static Textarea = props => <TextareaControl {...props} />;
    static Dropdown = props => <SelectControl {...props} />;

    static Checkbox = props => <CheckboxControl {...props} />;
    static Radio = props => <RadioControl {...props} />;

    static stringToControlMap = {
        'text': Form.Text,
        'password': Form.Password,
        'textarea': Form.Textarea,
        'dropdown': Form.Dropdown,
    };

    static EmptyField = (props) => <Columns.Column size={6} />;

    static Field = ({ fullwidth, component, ...props }) => {
        let colSize = fullwidth ? 12 : 6;
        let fieldType = Form.stringToControlMap[component] || component || Form.Text;
        let fieldComponent = Form.createRenderer(fieldType);
        return (
            <Columns.Column size={colSize}>
                <ReduxFormField component={fieldComponent} {...props} />
            </Columns.Column>
        );
    };

    // input{ name, onBlur, onChange, onDragStart, onDrop, onFocus, value }
    static createRenderer = render => ({ input, meta, label, ...props }) => {
        const Element = render; 
        return (
            <Field>
                <Label>{label}</Label>
                <Control>
                    <Element {...input} {...props} />
                </Control>
            </Field>
        );
    };

    render() {
        const { children } = this.props;
        return (
            <form>
                <Columns multiline>
                    {children}
                </Columns>
            </form>
        );
    }
}
