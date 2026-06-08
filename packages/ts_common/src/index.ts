export type BackendProvider = 'supabase' | 'neon';

export interface ShopSummary {
  id: string;
  name: string;
  prefecture: string;
  latitude: number;
  longitude: number;
}
