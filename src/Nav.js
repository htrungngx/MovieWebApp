import React, { useEffect, useState } from 'react'
import './Nav.css'

function Nav() {

    const [show, setShow] = useState(false);

    useEffect(() => {
        window.addEventListener("scroll", () => {
            if(window.scrollY > 100) {
                setShow(true)
            } else {
                setShow(false)
            }
        })
        return () => {
            window.removeEventListener("scroll")
        }
    }, []);

    return (
        <div className={`nav ${show && "nav--black"}`}>
            <img
                className="nav__logo"
                src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Netflix_2015_logo.svg/2560px-Netflix_2015_logo.svg.png"
                alt="Netflix Logo"
            />
            <img
                className="nav__avatar"
                src="https://ih0.redbubble.net/image.618385909.1713/flat,1000x1000,075,f.u2.jpg"
                alt="Netflix Logo"
            />
        </div>

    )
}

export default Nav