
//
// Actions
//

const OPEN_SLIDE = 'october/slides/OPEN_SLIDE'
const CLOSE_SLIDE = 'october/slides/CLOSE_SLIDE'

//
// Reducers
//

const initialState = {
    isOpen: false,
    activeSlide: null
}

export default function reducer(state = initialState, action) {
    switch (action.type) {
        case OPEN_SLIDE:
            return {
                isOpen: true,
                activeSlide: action.slide
            }
        case CLOSE_SLIDE:
            return {}
        default:
            return state
    }
}

//
// Action Creators
//

export const SlideActions = {
    onOpenSlides,
    onCloseSlides,
}

export function onOpenSlides(slide) {
    return { type: OPEN_SLIDE, slide }
}

export function onCloseSlides() {
    return { type: CLOSE_SLIDE }
}
