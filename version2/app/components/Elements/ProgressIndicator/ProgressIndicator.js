import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import styles from './ProgressIndicator.scss';

const ProgressIndicator = ({
    steps,
    currentStepIndex,
    ...props
}) => {
    return (
        <div {...props} className={styles.progressContainer}>
            <ul>
                {steps.map((step, index) => (
                    <li key={index} className={classnames({
                        [styles.active]: index == currentStepIndex,
                        [styles.done]: index < currentStepIndex
                    })}>
                        <h6>{step}</h6>
                        <span className={styles.progressWidget}>
                            <span className={styles.progressIndicator}></span>
                        </span>
                    </li>
                ))}
            </ul>
        </div>
    );
};

ProgressIndicator.propTypes = {
    steps: PropTypes.array,
    currentStepIndex: PropTypes.number,
};

ProgressIndicator.defaultProps = {
    steps: [],
    currentStepIndex: 0,
};

export default ProgressIndicator;
