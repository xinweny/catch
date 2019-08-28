require('dotenv').config();

import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import "../plugins/flatpickr";
import { autocomplete } from '../components/autocomplete';
import { setPosition } from '../components/geolocation';
import { googleMaps } from './map';

autocomplete();
setPosition();
googleMaps();
