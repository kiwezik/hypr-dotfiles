use bincode::{Decode, Encode};
use dbus::Message;
use log::{error, warn};

#[derive(Debug, Default, Clone, Encode, Decode, PartialEq)]
pub struct MprisPlayback {
    pub player_id: String,
    pub playing: Option<String>,
}

impl MprisPlayback {
    pub fn new(player_id: String) -> Self {
        Self {
            player_id,
            playing: None,
        }
    }

    pub fn is_playing(&self) -> bool {
        self.playing
            .clone()
            .map(|elem| elem == "Playing")
            .unwrap_or(false)
    }

    pub fn new_with_playing(player_id: String, playing: String) -> Self {
        Self {
            player_id,
            playing: Some(playing),
        }
    }

    pub fn from_dbus_message(msg: &Message) -> Self {
        let mut result = MprisPlayback::new(msg.sender().unwrap().to_string());

        for elem in msg.iter_init() {
            if let Some(args) = elem.as_iter() {
                if let Some(kv) = args.collect::<Vec<_>>().chunks(2).next() {
                    if let (Some(key), Some(value)) = (kv[0].as_str(), kv[1].as_str()) {
                        if key != "PlaybackStatus" {
                            warn!("tried to create MprisPlayback but message does not conform to expected format");
                            return result;
                        }
                        result.playing = Some(value.to_string());
                        return result;
                    } else {
                        warn!("got unexpected key-value pair, types do not conform to expected format");
                        return result;
                    }
                }
            };
        }

        error!("got to end of MprisPlayback constructor without returning during construction, this should not happen");
        result
    }
}
