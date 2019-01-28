import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classnames from 'classnames'
import styles from './LogPanel.scss'
import brace from 'brace'

export default class LogPanel extends Component {
    static propTypes = {
        logText: PropTypes.string,
        toolbarControls: PropTypes.bool,
    };

    static defaultProps = {
        logText: "",
        toolbarControls: true,
    };

    getViewerPanel() {
        return this.refs.textViewer
    }

    componentDidMount() {
        var editor = brace.edit(this.getViewerPanel())
        editor.setReadOnly(true)
        editor.setShowPrintMargin(false)
        editor.setHighlightActiveLine(false)
        editor.container.style.lineHeight = 2
        editor.renderer.updateFontSize()
        editor.$blockScrolling = Infinity
        editor.getSession().setUseWrapMode(true)
        // editor.setOption("firstLineNumber", this.log.getFirstLineNumber())
    }

    componentDidUpdate(prevProps, prevState) {
        if (prevProps.logText != this.props.logText) {
            var editor = brace.edit(this.getViewerPanel())
            editor.setValue(this.props.logText, 1)
            // editor.scrollToLine(this.log.lines.length, false, false)
            // editor.setOption("firstLineNumber", this.log.getFirstLineNumber())
        }
    }

    render() {
        const { logText, toolbarControls } = this.props;

        return (
            <div className={styles.logPanelContainer}>
                <div className={styles.panelControls}>
                    {toolbarControls && (
                        <React.Fragment>
                            <a className={styles.refresh} title="Refresh">
                                Refresh
                            </a>
                            <a className={styles.clear} title="Clear">
                                Clear
                            </a>
                        </React.Fragment>
                    )}
                </div>
                <div className={styles.textViewer} ref="textViewer">
                    {logText}
                </div>
            </div>
        );
    }
}
