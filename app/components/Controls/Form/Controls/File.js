import React, { PureComponent } from 'react'
import PropTypes from 'prop-types'
import classnames from 'classnames'
import Icon from '../../../Elements/Icon/Icon'
import * as colors from '../../../../constants/ColorConstants';

const colorMap = [null].concat(Object.keys(colors).map(key => colors[key]))

export default class Dropdown extends PureComponent {
    static propTypes = {
        className: PropTypes.string,
        style: PropTypes.shape({}),
        onChange: PropTypes.func,
        color: PropTypes.oneOf(colorMap),
        size: PropTypes.oneOf(['small', 'medium', 'large']),
        fileName: PropTypes.bool,
        fullwidth: PropTypes.bool,
        right: PropTypes.bool,
        boxed: PropTypes.bool,
        name: PropTypes.string,
        label: PropTypes.string,
    }

    static defaultProps = {
        className: '',
        style: {},
        onChange: null,
        color: null,
        size: null,
        fileName: true,
        fullwidth: true,
        right: false,
        boxed: false,
        name: null,
        label: 'Choose a file...',
    }

    select = (event) => {
        if (!this.props.fileName) {
            return
        }

        const file = event.target
        if (file && file.files.length > 0) {
            this.labelElement.innerHTML = file.files[0].name
        }

        if (this.props.onChange) {
            this.props.onChange()
        }
    }

    render() {
        const {
            className,
            style,
            onChange,
            color,
            size,
            fileName,
            fullwidth,
            right,
            boxed,
            name,
            label,
            ...props
        } = this.props

        return (
            <div
                style={style}
                className={classnames('file', className, {
                    [`is-${size}`]: size,
                    [`is-${color}`]: color,
                    'has-name': fileName,
                    'is-right': right,
                    'is-boxed': boxed,
                    'is-fullwidth': fullwidth,
                })}
            >
                <label className="file-label">
                    <input
                        {...props}
                        name={name}
                        value=""
                        type="file"
                        className="file-input"
                        onChange={this.select}
                    />
                    <span className="file-cta">
                        <span className="file-icon">
                            <Icon icon="fas fa-upload" />
                        </span>
                        <span className="file-label">
                            {label}
                        </span>
                    </span>
                    {fileName &&
                        <span className="file-name" ref={(node) => { this.labelElement = node }} />
                    }
                </label>
            </div>
        )
    }
}
