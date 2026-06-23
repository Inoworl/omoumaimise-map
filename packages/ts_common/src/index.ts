export type BackendProvider = 'supabase' | 'neon';
export type { Database, Json } from './database.types';

export interface ShopSummary {
  id: string;
  name: string;
  prefecture: string;
  latitude: number;
  longitude: number;
}
