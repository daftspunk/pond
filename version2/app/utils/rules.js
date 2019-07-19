const msgTemplate = (messageTemplate, args = [], value) => {
    messageTemplate = messageTemplate.replace(':name', name)
    let i = 1
    for(let msg of args) {
        messageTemplate = messageTemplate.replace(`:arg${i++}`, msg)
    }
    messageTemplate = messageTemplate.replace(':value', value)
    messageTemplate = messageTemplate.replace(':args', args.join(','))
    return messageTemplate
}

const _def = {
    required: 'Required',
    maxLength: `Must be :arg1 characters or less`,
    minLength: `Must be :arg1 characters or more`,
    alpha: 'Only alphabet characters',
    alphaNumeric: 'Only alphanumeric characters',
    alphaDash: 'Only alphabet or dash characters',
    number: 'Must be a number',
    email: 'Invalid email address',
    phoneNumber: 'Invalid phone number, must be 10 digits',
    minValue: `Must be at least :arg1`,
    maxValue: `Must be at most :arg1`,
    same: `This must have same value as :arg1`,
    difference: `This must have difference value as :arg1`,
    accepted: `Must accept this first`
}


export default {
    required: (msg = _def.required) => (value, args, x, v) => {
        return value ? undefined : msgTemplate(msg, [], value)
    },
    maxLength: (msg = _def.maxLength) => (max => (value => value && value.length > max ? msgTemplate(msg, [max], value) : undefined)),
    minLength: (msg = _def.minLength) => (min => (value => value && value.length < min ? msgTemplate(msg, [min], value) : undefined)),
    alpha: (msg = _def.alpha) => value => value && /[^a-zA-Z ]/i.test(value) ? msgTemplate(msg, [], value) : undefined,
    alphaDash: (msg = _def.alphaDash) => value => value && /[^a-zA-Z_ ]/i.test(value) ? msgTemplate(msg, [], value) : undefined,
    alphaNumeric: (msg = _def.alphaNumeric) => value => value && /[^a-zA-Z0-9 ]/i.test(value) ? msgTemplate(msg, [], value) : undefined,
    number: (msg = _def.number) => value => value && isNaN(Number(value)) ? msgTemplate(msg, [], value) : undefined,
    email: (msg = _def.email) => value => value && !/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i.test(value) ? msgTemplate(msg, [], value) : undefined,
    phoneNumber: (msg = _def.phoneNumber) => value => value && !/^(0|[1-9][0-9]{9})$/i.test(value) ? msgTemplate(msg, [], value) : undefined,
    minValue: (msg = _def.minValue) => min => value => value && value < min ? msgTemplate(msg, [min], value) : undefined,
    maxValue: (msg = _def.maxValue) => max => value => value && value > max ? msgTemplate(msg, [max], value) : undefined,
    same: (msg = _def.same) => name => (value, fields) => fields[name] === value ? undefined : msgTemplate(msg, [name], value),
    difference: (msg = _def.difference) => name => (value, fields) => fields[name] !== value ? undefined : msgTemplate(msg, [name], value),
    accepted: (msg = _def.accepted) => value => !!value ? undefined : msgTemplate(msg, [name], value),
    datetime: (msg = _def.datetime) => value => isNaN(Date.parse(value)) ? msgTemplate(msg, [], value) : undefined
}
