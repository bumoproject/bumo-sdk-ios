/*
	dxl is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	dxl is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with dxl.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef UTILS_THREAD_H_
#define UTILS_THREAD_H_

#include "utils.h"

namespace utils {
	typedef std::function<void()> ThreadCallback;

	class Thread;
	class Runnable {
	public:
		Runnable() {}
		virtual ~Runnable() {}

		virtual void Run(Thread *this_thread) = 0;
	};

	//thread 
	class Thread {
	public:
		explicit Thread() :
			target_(NULL)
			, enabled_(false)
			, running_(false)
			, handle_(Thread::INVALID_HANDLE)
			, thread_id_(0) {}

		explicit Thread(Runnable *target)
			: target_(target)
			, enabled_(false)
			, running_(false)
			, handle_(Thread::INVALID_HANDLE)
			, thread_id_(0) {}

		~Thread() {
		}

		//stop thread, return true if succeed
		bool Stop();

		//force to terminate thread
		bool Terminate();

		bool Start(std::string name = "");

		//stop and waiting for thead stopping
		bool JoinWithStop();

		bool enabled() const { return enabled_; };

		size_t thread_id() const { return thread_id_; };

		bool IsRunning() const { return running_; };

		//get current thread id
		static size_t current_thread_id();

		bool IsObjectValid() const { return Thread::INVALID_HANDLE != handle_; }

		static bool SetCurrentThreadName(std::string name);

		const std::string &GetName() const { return name_; }

	protected:
		UTILS_DISALLOW_EVIL_CONSTRUCTORS(Thread);
		std::string name_;

#ifdef WIN32
		static DWORD WINAPI threadProc(LPVOID param);
#else
		static void *threadProc(void *param);
#endif
		volatile bool enabled_;
		bool running_;

		Runnable *target_;

#ifdef WIN32
		HANDLE handle_;
		static const HANDLE INVALID_HANDLE;
#else
		pthread_t handle_;
		static const pthread_t INVALID_HANDLE;
#endif
		size_t thread_id_;

	protected:
		virtual void Run();
	};

	//thread group
	class ThreadGroup {
	public:
		ThreadGroup() {}
		~ThreadGroup() {
			JoinAll();
			for (size_t i = 0; i < _threads.size(); ++i) {
				delete _threads[i];
			}

			_threads.clear();
		}

		void AddThread(Thread *thread) {
			_threads.push_back(thread);
		}

		void StartAll() {
			for (size_t i = 0; i < _threads.size(); ++i) {
				_threads[i]->Start();
			}
		}

		void JoinAll() {
			for (size_t i = 0; i < _threads.size(); ++i) {
				_threads[i]->JoinWithStop();
			}
		}

		void StopAll() {
			for (size_t i = 0; i < _threads.size(); ++i) {
				_threads[i]->Stop();
			}
		}

		size_t size() const { return _threads.size(); }

	private:
		UTILS_DISALLOW_EVIL_CONSTRUCTORS(ThreadGroup);
		std::vector<Thread *> _threads;
	};

	class Mutex {
	public:
		Mutex();
		~Mutex();

		void Lock();
		void Unlock();
		pthread_mutex_t *mutex_pointer() { return &mutex_; }

	private:
		UTILS_DISALLOW_EVIL_CONSTRUCTORS(Mutex);

		uint32_t thread_id_;
		pthread_mutex_t mutex_;
	};

	class MutexGuard {
	public:
		MutexGuard(Mutex &mutex)
			: _mutex(mutex) {
			_mutex.Lock();
		}

		~MutexGuard() {
			_mutex.Unlock();
		}
	private:
		UTILS_DISALLOW_EVIL_CONSTRUCTORS(MutexGuard);
		Mutex &_mutex;
	};

	class ReadWriteLock {
	public:
		ReadWriteLock();
		~ReadWriteLock();

		void ReadLock();
		void ReadUnlock();
		void WriteLock();
		void WriteUnlock();

	private:
		UTILS_DISALLOW_EVIL_CONSTRUCTORS(ReadWriteLock);
		volatile long _reads;
		Mutex _enterLock;
	};

	class ReadLockGuard {
	public:
		ReadLockGuard(ReadWriteLock &lock)
			: lock_(lock) {
			lock_.ReadLock();
		}
		~ReadLockGuard() { lock_.ReadUnlock(); }
	private:
		UTILS_DISALLOW_EVIL_CONSTRUCTORS(ReadLockGuard);
		ReadWriteLock &lock_;
	};

	class WriteLockGuard {
	public:
		WriteLockGuard(ReadWriteLock &lock)
			: lock_(lock) {
			lock_.WriteLock();
		}
		~WriteLockGuard() { lock_.WriteUnlock(); }
	private:
		UTILS_DISALLOW_EVIL_CONSTRUCTORS(WriteLockGuard);
		ReadWriteLock &lock_;
	};


	// implement a spin lock using lock free.

	class SpinLock {
	public:
		/** ctor */
		SpinLock() :m_busy(SPINLOCK_FREE) {

		}

		/** dtor */
		virtual	~SpinLock() {

		}

		// lock
		inline void Lock() {
			while (SPINLOCK_BUSY == LOCK_CAS(&m_busy, SPINLOCK_BUSY, SPINLOCK_FREE)) {
				LOCK_YIELD();
			}
		}

		// unlock
		inline void Unlock() {
			LOCK_CAS(&m_busy, SPINLOCK_FREE, SPINLOCK_BUSY);
		}

	private:
		SpinLock(const SpinLock&);
		SpinLock& operator = (const SpinLock&);
		volatile uint32_t m_busy;
		static const int SPINLOCK_FREE = 0;
		static const int SPINLOCK_BUSY = 1;
	};

}

#endif // _UTILS_THREAD_H_
