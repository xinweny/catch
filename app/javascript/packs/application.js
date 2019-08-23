import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import "../plugins/flatpickr";
import { autocomplete } from '../components/autocomplete';
import { googleMaps } from './map';

autocomplete();
googleMaps();
